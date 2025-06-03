import os
import json
import re

CHATDATA_DIR = os.path.join(os.path.dirname(__file__), "Data", "ChatData")
STOPWORDS_FILE = os.path.join(CHATDATA_DIR, "stopwords.txt")
FAQ_FILE = os.path.join(CHATDATA_DIR, "FAQ.json")

# Common English stopwords
STOPWORDS = {
    "a", "about", "above", "after", "again", "against", "all", "am", "an", "and", "any", "are", "aren't", "as", "at",
    "be", "because", "been", "before", "being", "below", "between", "both", "but", "by",
    "can", "cannot", "could", "couldn't",
    "did", "didn't", "do", "does", "doesn't", "doing", "don't", "down", "during",
    "each",
    "few", "for", "from", "further",
    "had", "hadn't", "has", "hasn't", "have", "haven't", "having", "he", "he'd", "he'll", "he's", "her", "here", "here's", "hers", "herself", "him", "himself", "his", "how", "how's",
    "i", "i'd", "i'll", "i'm", "i've", "if", "in", "into", "is", "isn't", "it", "it's", "its", "itself",
    "let's",
    "me", "more", "most", "mustn't", "my", "myself",
    "no", "nor", "not",
    "of", "off", "on", "once", "only", "or", "other", "ought", "our", "ours", "ourselves", "out", "over", "own",
    "same", "shan't", "she", "she'd", "she'll", "she's", "should", "shouldn't", "so", "some", "such",
    "than", "that", "that's", "the", "their", "theirs", "them", "themselves", "then", "there", "there's", "these", "they", "they'd", "they'll", "they're", "they've", "this", "those", "through", "to", "too",
    "under", "until", "up",
    "very",
    "was", "wasn't", "we", "we'd", "we'll", "we're", "we've", "were", "weren't", "what", "what's", "when", "when's", "where", "where's", "which", "while", "who", "who's", "whom", "why", "why's", "with", "won't", "would", "wouldn't",
    "you", "you'd", "you'll", "you're", "you've", "your", "yours", "yourself", "yourselves"
}

def save_stopwords():
    with open(STOPWORDS_FILE, "w") as f:
        for word in sorted(STOPWORDS):
            f.write(word + "\n")

def get_keywords_from_file(filepath):
    with open(filepath, encoding="utf-8") as f:
        text = f.read().lower()
    # Extract words (alphanumeric, ignore punctuation)
    words = set(re.findall(r'\b[a-z][a-z0-9\-]*\b', text))
    # Remove stopwords and short words
    keywords = {w for w in words if w not in STOPWORDS and len(w) > 2}
    return sorted(keywords)

def main():
    # Save stopwords file if not present
    if not os.path.exists(STOPWORDS_FILE):
        save_stopwords()

    faq_entries = []
    for filename in os.listdir(CHATDATA_DIR):
        if filename.endswith(".txt") and filename not in ("FAQ.txt", "stopwords.txt"):
            filepath = os.path.join(CHATDATA_DIR, filename)
            keywords = get_keywords_from_file(filepath)
            if keywords:
                faq_entries.append({
                    "keywords": keywords,
                    "filename": filename
                })

    # Write new FAQ.txt
    with open(FAQ_FILE, "w", encoding="utf-8") as f:
        json.dump(faq_entries, f, indent=2)

    print(f"Updated {FAQ_FILE} with {len(faq_entries)} entries.")

if __name__ == "__main__":
    main()